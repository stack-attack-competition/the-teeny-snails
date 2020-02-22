defmodule Challenge do
  defstruct id: "",
  isDeleted: false,
  author: "",
  title: "",
  description: "",
  isActive: true,
  endDate: "",
  outcome: false,
  proofUrl: ""
end

defmodule User do
  defstruct id: "",
  isDeleted: false,
  email: "",
  password: "",
  firstName: "",
  lastName: "",
  pictureUrl: ""
end

defmodule Bet do
  defstruct id: "",
  isDeleted: false,
  author: "",
  challenge: "",
  inFavor: "",
  amount: 0,
  result: 0
end

# Dto definitions

defmodule LoginDto do
  defstruct email: "",
  password: ""

  def from_map(data) do
    %LoginDto{
      email: data["email"],
      password: data["password"]
    }
  end
end

defmodule UserDto do
  defstruct email: "",
  password: "",
  firstName: "",
  lastName: "",
  pictureUrl: ""

  def from_map(data) do
    %UserDto{
      email: data["email"],
      password: data["password"],
      firstName: data["firstName"],
      lastName: data["lastName"],
      pictureUrl: data["pictureUrl"]
    }
  end
end

defmodule ChallengeDto do
  defstruct author: "",
  title: "",
  description: "",
  isActive: false,
  endDate: "",
  outcome: false,
  proofUrl: ""

  def from_map(data) do
    %ChallengeDto{
      author: data["author"],
      title: data["title"],
      description: data["description"],
      isActive: data["isActive"],
      endDate: data["endDate"],
      outcome: data["outcome"],
      proofUrl: data["proofUrl"],
    }
  end
end

defmodule BetDto do
  defstruct amount: 0,
  author: "",
  challenge: "",
  inFavor: false,
  result: 0

  def from_map(data) do
    %BetDto{
      amount: data["amount"],
      author: data["author"],
      challenge: data["challenge"],
      inFavor: data["inFavor"],
      result: data["result"]
    }
  end
end

defmodule DbDto do
  defstruct users: [],
  challenges: [],
  bets: []

  def from_map(data) do
    %DbDto{
      users: data["users"],
      challenges: data["challenges"],
      bets: data["bets"]
    }
  end
end