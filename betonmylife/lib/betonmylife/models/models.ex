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
end

defmodule UserDto do
  defstruct email: "",
  password: "",
  firstName: "",
  lastName: "",
  pictureUrl: ""
end

defmodule ChallengeDto do
  defstruct author: "",
  title: "",
  description: "",
  isActive: false,
  endDate: "",
  outcome: false,
  proofUrl: ""
end

defmodule BetDto do
  defstruct author: "",
  challenge: "",
  inFavor: false,
  amount: 0,
  result: 0
end

defmodule DbDto do
  defstruct users: [],
  challenges: [],
  bets: []
end