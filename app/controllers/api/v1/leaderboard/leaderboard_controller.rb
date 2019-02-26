class Api::V1::Leaderboard::LeaderboardController < Api::BaseController

  def index
    @users = ::User.leaderboard.to_json
    respond_with @users
  end

end
