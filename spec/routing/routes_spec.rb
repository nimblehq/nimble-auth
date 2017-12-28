require 'spec_helper'

describe 'routes for BuriAuth' do
  routes { BuriAuth::Engine.routes }

  describe 'Custom Routes' do
    context 'Registrations' do
      it '[GET] Renders the signup page' do
        expect(get: '/auth/signup').to route_to(controller: 'devise/registrations', action: 'new')
      end
    end

    context 'Sessions' do
      it '[GET] Renders the login page' do
        expect(get: '/auth/signin').to route_to(controller: 'devise/sessions', action: 'new')
      end

      it '[POST] Accepts login requests' do
        expect(post: '/auth/signin').to route_to(controller: 'devise/sessions', action: 'create')
      end

      it '[GET] Accepts logout requests' do
        expect(get: '/auth/signout').to route_to(controller: 'devise/sessions', action: 'destroy')
      end
    end
  end
end
