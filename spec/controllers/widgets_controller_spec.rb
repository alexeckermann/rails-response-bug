require 'spec_helper'

describe WidgetsController do
  render_views

  let(:widget) { FactoryGirl.create(:account) }

  context 'with an authenticated account' do

    # before do
    #   authenticate_with_account(account)
    # end

    describe 'POST to create' do

      context 'with correct parameters' do

        let(:widget_params) { FactoryGirl.attributes_for(:widget) }

        it 'should be successful' do
          post :create, widget: widget_params, format: :json
          binding.pry unless response.success? # this is so one can inspect the response.body/status etc.
          response.should be_success
        end

        it 'should create a new device' do
          lambda {
            post :create, widget: widget_params, format: :json
          }.should change(Widget, :count).by(1)
          controller.widget.new_record?.should be_false
        end

        it 'should return the new device' do
          post :create, widget: widget_params, format: :json
          body = JSON.parse(response.body)
          %w(success widget path).all? { |k| body.key?(k) }.should be_true
        end

      end

      context 'with no parameters' do

        it 'should be unsuccessful' do
          post :create, post: {}, format: :json
          response.status.should eq(400)
        end

      end

      context 'with empty parameters, invalid data' do

        let(:widget_params) { { name: '', description: '' } }

        it 'should be unsuccessful' do
          post :create, widget: widget_params, format: :json
          response.status.should eq(422)
        end

        it 'should not create a new widget' do
          lambda {
            post :create, widget: widget_params, format: :json
          }.should_not change(Widget, :count)
          controller.widget.new_record?.should be_true
          controller.widget.errors.any?.should be_true
        end

        it 'should return some errors' do
          post :create, widget: widget_params, format: :json
          body = JSON.parse(response.body)
          %w(success errors).all? { |k| body.key?(k) }.should be_true
          body['errors'].any?.should be_true
        end

      end

    end

  end

end