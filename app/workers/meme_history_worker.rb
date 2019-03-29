class MemeHistoryWorker
  include Sidekiq::Worker

  def perform
    memes = Meme.active.all

    ActiveRecord::Base.transaction do
      memes.each_slice(1000) do |data|
        values = data.map do |meme|
          price = Rails.application.config.Reddit.from_ids('t3_' + meme[:reddit_id]).to_ary[0].score
          "(#{meme[:id]},'#{meme[:reddit_id]}',#{price},'#{Time.now.to_s}','#{Time.now.to_s}','#{Time.now.to_s}')"
        end.join(",")

        sql = "INSERT INTO meme_histories (meme_id, reddit_id, price, date, created_at, updated_at) VALUES #{values}"
        ActiveRecord::Base.connection.execute(sql)
      end
    end
  end
end
