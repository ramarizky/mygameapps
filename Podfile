# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'
 

source 'https://github.com/ramarizky/Modularization-ProfilePodSpecs-Module'

use_frameworks!
workspace 'Modularization'
 
target 'MyGameApps' do
  # Pods for App
end
 
target 'Detail' do
  project '../Detail/Detail'
end

target 'Core' do
  project '../Core/Core'
end

target 'Favourite' do
  project '../Favourite/Favourite'
end

target 'Home' do
  project '../Home/Home'
  pod 'Profile'
end
