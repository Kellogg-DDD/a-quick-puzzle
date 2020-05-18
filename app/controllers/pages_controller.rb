class PagesController < ApplicationController
  def puzzle
    priorGuesses = session.fetch(:guesses)
    if priorGuesses.class == NilClass
      priorGuesses = Array.new
      @guessesEmpty = true
    else
      @guessesEmpty = false
    end 

    finalGuess = session.fetch(:answerGuess)
    if finalGuess.class == NilClass
      @finalGuess = false
    else
      @finalGuess = true
    end 

    render({ :template => "pages/puzzle.html.erb" })
  end
  
  def write_cookie
    @first = params.fetch("first_num").to_f;
    @second = params.fetch("second_num").to_f;
    @third = params.fetch("third_num").to_f;

    priorGuesses = session.fetch(:guesses)
    if priorGuesses.class == NilClass
      priorGuesses = Array.new
    end 

    if @first < @second && @second < @third 
      @outcome = "success"
    else
      @outcome = "failure"      
    end

    currentGuesses = [
      @first, @second, @third, @outcome
    ]

    priorGuesses.push(currentGuesses)
    session.store(:guesses, priorGuesses) 

    redirect_to("/")
  end

  def guess_answer
    @answer = params.fetch("guess")
    session.store(:answerGuess, @answer)
    redirect_to("/")
  end
end
