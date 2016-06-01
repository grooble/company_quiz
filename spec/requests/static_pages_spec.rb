require 'spec_helper'

describe "StaticPages" do

  subject { page }
  
  describe "Home page" do
    before { visit root_path }
	
    it { should have_selector('h1', text: I18n.t('welcome')) }
    it { should have_selector('title', text: full_title('')) }
	
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem")
        FactoryGirl.create(:micropost, user: user, content: "Ipsum")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 #{I18n.t('stats.following')}", href: following_user_path(user)) }
        it { should have_link("1 #{I18n.t('stats.followers')}", href: followers_user_path(user)) }
      end
    end
  end
  
  describe "Help page" do
    before { visit help_path }
  
	it { should have_selector('h1', text: I18n.t('static.help.title')) }
	it { should have_selector('title', text: full_title(I18n.t('static.help.title'))) }
  end
  
  describe "About page" do
    before { visit about_path }
  
    it { should have_selector('h1', text: I18n.t('static.about.title')) }
	it { should have_selector('title', text: full_title(I18n.t('static.about.title'))) }
  end
  
  describe "Contact page" do
    before { visit contact_path }
	
	it { should have_selector('h1', text: I18n.t('static.contact.title')) }
	it { should have_selector('title', text: full_title(I18n.t('static.contact.title'))) }
  end
end
