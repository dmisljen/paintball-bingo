<?php

namespace App\Http\Controllers\Match;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

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
            ->select('bingo_match.name', 'bingo_match.start_at as start_time', 'bingo_prize.name as main_prize')
            ->where('bingo_match.start_at', '>', now())
            ->where('bingo_match_prize.prize_order', 1)
            ->get();

        return $matches;
    }
}
