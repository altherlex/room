class CrawlerMailer < ActionMailer::Base
  default from: 'notification@crawler-room.com'
  #default from: "crawler.room@gmail.com"
 
  def info_collected(crawler)
    @url  = 'http://crawler-room.herokuapp.com/'
    @crawler = crawler
    puts crawler.show.inspect
    mail(to: crawler.user.email, subject: "Collected internet's info")
  end
end
