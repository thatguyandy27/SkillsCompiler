require 'spec_helper'

describe "Static Pages" do
  
  subject {page}

  describe "Home page" do 
    before{ visit root_path}
    it { should have_content("Top #{SkillTotal.DEFAULT_SKILL_COUNT} skills")}
    
  end


  describe "About page" do 
    before { visit about_path}
    it { should have_content("About")}
  end

  describe "Contact page" do 
    before { visit contact_path}

    it { should have_content("Contact")}
  end
end