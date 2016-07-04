defmodule Issues.GithubIssues do

  @user_agent [{"user-agent", "Elixir Y"}]

 def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_reponse
 end

 def handle_reponse({:ok, %{status_code: 200, body: body}}) do
   {:ok, Poison.Parser.parse!(body)}
 end

 def handle_reponse({_, %{status_code: ___, body: body}}) do
   {:error, Poison.Parser.parse!(body)}
 end

 # use a module attribute to fetch the value at compile time
 @github_url Application.get_env(:issues, :github_url)

 def issues_url(user, project) do
   "#{@github_url}/repos/#{user}/#{project}/issues"
 end

end
