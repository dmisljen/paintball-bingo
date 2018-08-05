<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

/**
 * API Match Controllers
 * All route names are prefixed with 'match'.
 */
Route::group(['namespace' => 'Match', 'prefix' => 'match', 'as' => 'match.'], function () {
    Route::get('/list', 'MatchController@match_list')->name('list');
    Route::get('/enter/{match_id}', 'MatchController@enter_match')->name('enter');
    Route::get('/history', 'MatchController@match_history')->name('history');
    Route::get('/{match_id}/new_event/{event_id}', 'MatchController@new_event')->name('new_event');
});

/**
 * API Card Controllers
 * All route names are prefixed with 'card'.
 */
Route::group(['namespace' => 'Card', 'prefix' => 'card', 'as' => 'card.'], function () {
    Route::get('/{card_id}/tick_event/{event_id}', 'CardController@tick_event')->name('tick_event');
    Route::get('/{card_id}/claim_bingo', 'CardController@claim_bingo')->name('claim_bingo');
});