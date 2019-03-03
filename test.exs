defmodule Test do
  use Assertion

  test "integers can be added and subtracted" do
    assert 2 + 3 == 5
    assert 5 - 5 == 0
  end

  test "integers can be multiplied and divided" do
    assert 5 * 5 == 24
    assert 10 / 2 == 5
  end
end
