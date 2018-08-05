<?php

namespace App\Http\Controllers\Card;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

/**
 * Class CardController.
 */
class CardController extends Controller
{
    /**
     * Logged-in user id
     */
    private $user_id;

    /**
     * Initialize common values
     *
     * @return void
     */
    public function __construct()
    {
        // We will assume user_id is valid since this part should be handeled by the authentication process
        $headers = apache_request_headers();
        $this->user_id = isset($headers["user_id"]) ? $headers["user_id"] : 0;
    }

    /**
     * Tick/hit an event
     * 
     * @param integer card_id
     * @param integer event_id
     * 
     * @return json $response
     */
    public function tick_event($card_id, $event_id)
    {
        // High-quality "validation" of inputs
        $card_id = $this->validate_int($card_id);
        $event_id = $this->validate_int($event_id);

        // Get card and check if it's valid
        $valid_card = $this->get_card($card_id);

        if ($valid_card) {
            // Get all current events in the match
            $match_events = DB::table("bingo_match_event")
                ->where("match_id", $valid_card->match_id)
                ->get();

            // Get events in the card
            $card_events = $this->get_card_events($valid_card->id)->pluck("bingo_event_id");

            if (count($match_events) && count($card_events)) {
                // Check if the sent event actually happened and exists in the users card
                $match_events_index = array_flip(array_column($match_events->toArray(), "bingo_event_id", "id"));
                $card_events_index = array_flip($card_events->toArray());

                if (isset($match_events_index[$event_id]) && isset($card_events_index[$event_id])) {
                    // Possible TODO: check if event is already hit
                    DB::table("bingo_card_event")
                        ->where("bingo_card_id", $valid_card->id)
                        ->where("bingo_event_id", $event_id)
                        ->update(["hit_at" => date("Y-m-d H:i:s"), "hit_match_event_id" => $match_events_index[$event_id]]);

                    return array("success" => true, "message" => "Event ticked!");
                } else {
                    return array("success" => false, "message" => "The specified event wasn't found!");
                }
            } else {
                return array("success" => false, "message" => "Match or card events not found!");
            }
        } else {
            return array("success" => false, "message" => "Please check your data, the specified bingo card was not found!");
        }
    }

    /**
     * Claim bingo on a card
     * 
     * @param integer card_id
     * 
     * @return json $response
     */
    public function claim_bingo($card_id)
    {
        // High-quality "validation" of inputs
        $card_id = $this->validate_int($card_id);
        
        $valid_card = $this->get_card($card_id);

        if ($valid_card) {

            if ($valid_card->won > 0) return array("success" => false, "message" => "You have already claimed bingo for this card!");
            
            // Get events in the card
            $card_events = $this->get_card_events($valid_card->id)->pluck("hit_at")->toArray();

            $row_bingo = false;
            $col_bingo = false;

            // Check for a non-null card row or column
            for ($i=0; $i<4; $i++) {
                $is_row_hit = true;
                $is_col_hit = true;

                for ($j=0; $j<4; $j++) {
                    if ($card_events[($i * 4) + $j] == null) $is_row_hit = false;
                    if ($card_events[$i + ($j * 4)] == null) $is_col_hit = false;
                }

                if($is_row_hit) $row_bingo = true;
                if($is_col_hit) $col_bingo = true;
            }

            if ($row_bingo || $col_bingo) {  // Yay, BINGO!
                $winning_event = DB::table('bingo_card_event')
                    ->where('bingo_card_id', $valid_card->id)
                    ->orderBy('hit_at', "desc")
                    ->first();
                $winnig_cards_for_match = DB::table("bingo_card")
                    ->where("match_id", $valid_card->match_id)
                    ->orderBy("won", "desc")
                    ->first();
                
                if ($winnig_cards_for_match) $prize_number = $winnig_cards_for_match->won + 1;
                else $prize_number = 1;

                // Update Card
                $update_card_data = array(
                    "won" => $prize_number, 
                    "win_match_event_id" => $winning_event->id,
                    "won_at" => date("Y-m-d H:i:s")
                );
                DB::table("bingo_card")
                    ->where("id", $valid_card->id)
                    ->update($update_card_data);

                // Update Match Event
                // This event can be a winner for more than one card so I'm not sure 
                // if a simple 1(true) or the prize number would be a better fit here
                $update_match_event_data = array(
                    "is_winner_event" => $prize_number
                );
                DB::table("bingo_match_event")
                    ->where("id", $winning_event->hit_match_event_id)
                    ->update($update_match_event_data);

                // Update Match Prize
                // Not really necessary for now, but maybe it will be needed somewhere down the road
                $update_match_prize_data = array(
                    "winner_id" => $this->user_id
                );
                DB::table("bingo_match_prize")
                    ->where("match_id", $valid_card->match_id)
                    ->where("prize_order", $prize_number)
                    ->update($update_match_prize_data);

                if ($prize_number == 1) {
                    // Update Match
                    // Also not really necessary, redundant data, but it can make some selects easier
                    $update_match_data = array(
                        "winner_bingo_card_id" => $valid_card->id
                    );
                    DB::table("bingo_match")
                        ->where("id", $valid_card->match_id)
                        ->update($update_match_data);
                }

                return array("success" => true, "message" => "Congratulations! You have won $prize_number. prize in PAINTBALL BINGO!");
            } else {
                return array("success" => false, "message" => "Sorry, you don't have bingo with that card!");
            }
        } else {
            return array("success" => false, "message" => "Please check your data, the specified bingo card was not found!");
        }
    }

    /**
     * Validate integer input
     * 
     * @param mixed input
     * 
     * @return integer $validated_input
     */
    private function validate_int($input) {
        // Wow, much sanitation, such validated, very security!
        return (int) $input;
    }

    /**
     * Get card by id for current user
     * 
     * @param integer card_id
     * 
     * @return stdClass or null $card
     */
    private function get_card($card_id) {
        $valid_card = DB::table("bingo_card")
            ->where("id", $card_id)
            ->where("user_id", $this->user_id)
            ->first();

        return $valid_card;
    }

    /**
     * Get card events for a card
     * 
     * @param integer card_id
     * 
     * @return Collection $card
     */
    private function get_card_events($card_id) {
        // Get events in the card
        $card_events = DB::table("bingo_card_event")
            ->where("bingo_card_id", $card_id)
            ->orderBy("id")
            ->get();

        return $card_events;
    }
}