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
        $valid_card = DB::table("bingo_card")
            ->where("id", $card_id)
            ->where("user_id", $this->user_id)
            ->first();

        if ($valid_card) {
            // Get all current events in the match
            $match_events = DB::table("bingo_match_event")
                ->where("match_id", $valid_card->match_id)
                ->get();

            // Get events in the card
            $card_events = DB::table("bingo_card_event")
                ->where("bingo_card_id", $valid_card->id)
                ->pluck("bingo_event_id");

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
        $card_id = (int) $card_id;
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
}