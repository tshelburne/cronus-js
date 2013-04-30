assets_are_in "#{::Cronus.root_path}/assets"

asset 'cronus.js' do |a|
	a.scan 'scripts/coffee'
	a.toolchain :coffeescript, :require
	a.post_build :closure
end
