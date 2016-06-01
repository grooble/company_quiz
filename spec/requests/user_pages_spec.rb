require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all) { User.delete_all }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: I18n.t('index.all_users')) }
    it { should have_selector('h1', text: I18n.t('index.all_users')) }

    describe "pagination" do
      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link(I18n.t('control.delete')) }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link(I18n.t('control.delete'), href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link(I18n.t('control.delete')) }.to change(User, :count).by(-1)
        end
        it { should_not have_link(I18n.t('control.delete'), href: user_path(admin)) }
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('title', text: full_title( I18n.t('page.signin.new_user_link'))) }
    it { should have_selector('h1', text: I18n.t('page.signin.new_user_link')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end

	describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button I18n.t('user.follow')
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button I18n.t('user.follow')
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button I18n.t('user.follow') }
          it { should have_selector('input', value: I18n.t('user.unfollow')) }
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button I18n.t('user.unfollow')
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button I18n.t('user.unfollow')
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button I18n.t('user.unfollow') }
          it { should have_selector('input', value: I18n.t('user.follow')) }
        end
      end
    end
  end

  describe "signup" do
    
    before { visit signup_path }

    let(:submit) { I18n.t('page.signin.submit') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: I18n.t('page.signin.new_user_link')) }
        it { should have_content('error') }
        it { should_not have_content('Password digest') }
      end
    end

    describe "with valid information" do

      before do
        fill_in I18n.t('form.name'), with: "Example User"
        fill_in I18n.t('form.email'), with: "user@example.com"
        fill_in I18n.t('form.password'), with: "foobar"
        fill_in I18n.t('form.verify'), with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving a user" do
        before { click_button submit }

        let(:user) { User.find_by_email("user@example.com") }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do

      it { should have_selector('h1', text: I18n.t('edit.title')) }
      it { should have_selector('title', text: I18n.t('edit.user')) }
      it { should have_link('change', href: I18n.t('edit.avatar')) }
    end

    describe "with invalid information" do
      before { click_button I18n.t('edit.submit') }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in I18n.t('form.name'), with: new_name
        fill_in I18n.t('form.email'), with: new_email
        fill_in I18n.t('form.password'), with: user.password
        fill_in I18n.t('form.verify'), with: user.password
        click_button I18n.t('edit.submit')
      end

      it { should have_selector('title', text: new_name) }
      it { should have_link('Sign out', href: signout_path) }
      it { should have_selector('div.alert.alert-success') }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
  
  describe "followers/following" do
    let(:user) { FactoryGirl.create(:user) }
	let(:other_user) { FactoryGirl.create(:user) }
	before { user.follow!(other_user) }
	
	describe "followed users" do
	  before do
	    sign_in user
		visit following_user_path(user)
	  end
	  
	  it { should have_selector('title', test: full_title(I18n.t('stats.following'))) }
	  it { should have_selector('h3', text: I18n.t('stats.following')) }
	  it { should have_link(other_user.name, href: user_path(other_user)) }
	end
	
	describe "followers" do
	  before do
	    sign_in other_user
		visit followers_user_path(other_user)
	  end
	  it { should have_selector('title', text: full_title(I18n.t('stats.followers'))) }
	  it { should have_selector('h3', text: I18n.t('stats.followers')) }
	  it { should have_link(user.name, href: user_path(user)) }	  
	end
  end
end