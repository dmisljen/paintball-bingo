<?php

namespace App\Http\Controllers\Match;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

/**
 * Class MatchController.
 */
class MatchController extends Controller
{

    /**
     * Return all available matches a user can take part in
     * 
     * @return json $matches
     */
    public function match_list()
    {
        $matches = DB::table('bingo_match')
            ->join('bingo_match_prize', 'bingo_match_prize.match_id', '=', 'bingo_match.id')
            ->join('bingo_prize', 'bingo_prize.id', '=', 'bingo_match_prize.prize_id')
            ->select('bingo_match.id', 'bingo_match.name', 'bingo_match.start_at as start_time', 'bingo_prize.name as main_prize')
            ->where('bingo_match.start_at', '>', now())
            ->where('bingo_match_prize.prize_order', 1)
            ->get();

        return $matches;
    }

    /**
     * Request to enter a Paintball Match. If valid, create bingo card for the user
     * 
     * @param Request $request
     * @param integer user_id
     * 
     * @return json $response
     */
    public function enter_match(Request $request, $match_id)
    {
        // We will assume user_id is valid since this part should be handeled by the authentication process
        $headers = apache_request_headers();
        $user_id = $headers['user_id'];

        // Some proper validation would be required for the input,
        // but for now a cast to integer will probably suffice
        $match_id = (int) $match_id;

        $valid_match = DB::table('bingo_match')
            ->select('id')
            ->where("id", $match_id)
            ->where("start_at", ">", now())
            ->first();

        if ( isset($valid_match->id) ) {

            // Create a card for the user
            $card = array(
                "user_id" => $user_id,
                "match_id" => $match_id
            );
            
            $card_id = DB::table('bingo_card')->insertGetId( $card );

            if ( $card_id ) {
                // Let the DB engine randomize events and return the 16 of them that we need
                $events = DB::table('bingo_event')->inRandomOrder()->take(16)->get();

                // Insert card events
                $card_events = array();
                foreach ($events as $key => $event) {
                    $card_events[$key]["bingo_card_id"] = $card_id;
                    $card_events[$key]["bingo_event_id"] = $event->id;
                }

                DB::table('bingo_card_event')->insert( $card_events );

                return array("card_id" => $card_id, "events" => $events);
            }
        }

        return array("success" => false, "message" => "An error occured while trying to create a bingo card, please try again or contact one of our administrators.");
    }
}
