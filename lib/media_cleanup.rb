require 'find'
require 'fileutils'

class MediaCleanup
  def self.run
    %w(hof history).each do |mod|
      base = Rails.root.join('public', 'uploads', mod)
      Dir.entries(File.join(base)).reject{ |d| d =~ /^\.+/ }.each do |dir|
        puts dir
        Dir.entries(File.join(base, dir)).reject{ |d| d =~ /^\.+/ }.each do |subdir|
          ids = Dir.entries(File.join(base,dir,subdir)).reject { |d| d =~ /^\.+/ }.map(&:to_i)
          puts ids.inspect
          dbids = "#{mod.camelize}::#{dir.camelize}".constantize.find(:all).map(&:id)
          puts dbids.inspect
          (ids - dbids).each do |id|
            path = File.join(base, dir, subdir, id.to_s)
            puts "Removing #{path}"
            FileUtils.rm_rf path
          end
        end
      end
    end
  end
end
