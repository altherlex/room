class Crawler < ActiveRecord::Base
 # serialize :config
  def initialize
     @parametrize = [
        {links: [
          link: "www.google.com",
          selectors: [{handle:"#logo", id:"logo"}],
          send_emails: [{email:"your-email@your-domain.com", at:"12pm", every:"1.day"}]
        ]}
     ]
  end
end
