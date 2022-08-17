defmodule Concurrency.CountWordService do
  def count(text) do
    Concurrency.CountWordServer.count_word(text)
  end

  def get_words() do
    Concurrency.CountWordServer.words_count()
  end
end
