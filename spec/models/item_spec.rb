require 'rails_helper'

RSpec.describe Item, type: :model do

  describe "登録" do

    context "登録に成功する" do
      let(:item) {FactoryBot.build(:item)}

      it "全て正しく入力されている" do
        expect(user).to be_valid
        puts user.attributes
      end

    end

    context "登録に失敗する" do
      let(:item) {FactoryBot.build(:item)}
    end

  end

end
