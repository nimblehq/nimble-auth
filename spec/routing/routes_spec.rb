require 'spec_helper'

describe 'routes for BuriAuth' do
  routes { BuriAuth::Engine.routes }

  describe 'Custom Routes' do
    context 'Omniauth' do
      context 'Facebook' do
        it '[GET] Handles authentication request' do
          expect(get: '/auth/facebook/callback').to route_to(controller: 'buri_auth/omniauth_callbacks', action: 'facebook')
        end

        it '[POST] Handles authentication request' do
          expect(post: '/auth/facebook/callback').to route_to(controller: 'buri_auth/omniauth_callbacks', action: 'facebook')
        end
      end
    end

    context 'Registrations' do
      it '[GET] Renders the signup page' do
        expect(get: '/signup').to route_to(controller: 'devise/registrations', action: 'new')
      end
    end

    context 'Sessions' do
      it '[GET] Renders the login page' do
        expect(get: '/signin').to route_to(controller: 'devise/sessions', action: 'new')
      end

      it '[POST] Accepts login requests' do
        expect(post: '/signin').to route_to(controller: 'devise/sessions', action: 'create')
      end

      it '[GET] Accepts logout requests' do
        expect(get: '/signout').to route_to(controller: 'devise/sessions', action: 'destroy')
      end
    end
  end
end
