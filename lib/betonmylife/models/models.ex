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

  def from_dto(dto) do
    %Challenge{
      id: UUID.uuid4(),
      author: dto.author,
      title: dto.title,
      description: dto.description,
      isActive: dto.isActive,
      endDate: dto.endDate,
      outcome: dto.outcome,
      proofUrl: dto.proofUrl
    }
  end

  def update(current, dto) do
    cond do
      dto.author != nil ->
        current = struct(current, author: dto.author)
        dto = struct(dto, author: nil)
        update(current, dto)
      dto.title != nil ->
        current = struct(current, title: dto.title)
        dto = struct(dto, title: nil)
        update(current, dto)
      dto.description != nil ->
        current = struct(current, description: dto.description)
        dto = struct(dto, description: nil)
        update(current, dto)
      dto.isActive != nil ->
        current = struct(current, isActive: dto.isActive)
        dto = struct(dto, isActive: nil)
        update(current, dto)
      dto.endDate != nil ->
        current = struct(current, endDate: dto.endDate)
        dto = struct(dto, endDate: nil)
        update(current, dto)
      dto.outcome != nil ->
        current = struct(current, outcome: dto.outcome)
        dto = struct(dto, outcome: nil)
        update(current, dto)
      dto.proofUrl != nil ->
        current = struct(current, proofUrl: dto.proofUrl)
        dto = struct(dto, proofUrl: nil)
        update(current, dto)
      true -> current
    end
  end
end

defmodule User do
  defstruct id: "",
  isDeleted: false,
  email: "",
  password: "",
  firstName: "",
  lastName: "",
  pictureUrl: ""

  def from_dto(dto) do
    %User{
      id: UUID.uuid4(),
      email: dto.email,
      password: dto.password,
      firstName: dto.firstName,
      lastName: dto.lastName,
      pictureUrl: dto.pictureUrl
    }
  end

  def update(current, dto) do
    cond do
      dto.email != nil ->
        current = struct(current, email: dto.email)
        dto = struct(dto, email: nil)
        update(current, dto)
      dto.password != nil ->
        current = struct(current, password: dto.password)
        dto = struct(dto, password: nil)
        update(current, dto)
      dto.firstName != nil ->
        current = struct(current, firstName: dto.firstName)
        dto = struct(dto, firstName: nil)
        update(current, dto)
      dto.lastName != nil ->
        current = struct(current, lastName: dto.lastName)
        dto = struct(dto, lastName: nil)
        update(current, dto)
      dto.pictureUrl != nil ->
        current = struct(current, pictureUrl: dto.pictureUrl)
        dto = struct(dto, pictureUrl: nil)
        update(current, dto)
      true -> current
    end
  end
end

defmodule Bet do
  defstruct id: "",
  isDeleted: false,
  author: "",
  challenge: "",
  inFavor: "",
  amount: 0,
  result: 0

  def from_dto(dto) do
    %Bet{
      id: UUID.uuid4(),
      amount: dto.amount,
      author: dto.author,
      challenge: dto.challenge,
      inFavor: dto.inFavor,
      result: dto.result
    }
  end

  def update(current, dto) do
    cond do
      dto.amount != nil ->
        current = struct(current, amount: dto.amount)
        dto = struct(dto, amount: nil)
        update(current, dto)
      dto.author != nil ->
        current = struct(current, author: dto.author)
        dto = struct(dto, author: nil)
        update(current, dto)
      dto.challenge != nil ->
        current = struct(current, challenge: dto.challenge)
        dto = struct(dto, challenge: nil)
        update(current, dto)
      dto.inFavor != nil ->
        current = struct(current, inFavor: dto.inFavor)
        dto = struct(dto, inFavor: nil)
        update(current, dto)
      dto.result != nil ->
        current = struct(current, result: dto.result)
        dto = struct(dto, result: nil)
        update(current, dto)
      true -> current
    end
  end
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

  def create_validate(user) do
    cond do
      user.email == nil -> {:error, "Email missing"}
      user.password == nil -> {:error, "Password missing"}
      user.firstName == nil -> {:error, "First name missing"}
      user.lastName == nil -> {:error, "Last name missing"}
      user.pictureUrl == nil -> {:error, "Picture URL missing"}
      true -> {:ok}
    end
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