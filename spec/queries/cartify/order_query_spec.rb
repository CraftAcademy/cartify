require 'rails_helper'

module Cartify
  RSpec.describe OrdersQuery, type: :model do
    before(:all) do
      @user = create(:customer)
      in_delivery = create(:order_status, name: 'in_delivery')
      3.times { create(:order, :in_progress, user: @user) }
      2.times { create(:order, order_status: in_delivery, user: @user) }
    end
    subject { Cartify::OrdersQuery.new(@user.orders) }

    it 'unless give set to query it will work with none Order' do
      expect(Cartify::OrdersQuery.new.relation).to eq Order.none
    end

    it 'return self if no matches' do
      expect(subject.run('no such status')).to eq @user.orders
    end

    it 'return set of orders with one status' do
      subj = subject.run('in_progress').pluck(:order_status_id)
      expect(subj.uniq.size).to eq 1
    end

    it 'return set of orders with one status only In Progress' do
      subj = subject.run('in_progress').pluck(:order_status_id)
      expect(Cartify::OrderStatus.find(subj.first).name).to eq 'in_progress'
    end
  end
end
