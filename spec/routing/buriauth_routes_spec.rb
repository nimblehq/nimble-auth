describe 'routes for BuriAuth' do
  context 'default routes' do
    it 'draws the default routes' do
      expect(get: 'signin').to be_routable
    end
  end
end
