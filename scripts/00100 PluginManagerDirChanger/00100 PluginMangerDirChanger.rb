class PluginManager
  PSDKPLUG_SCRIPTS_FOLDER = 'scripts/psdkplugs'
  PLUGIN_INFO_FILE = "#{PSDKPLUG_SCRIPTS_FOLDER}/plugins.dat"
  
  private
  
  # Load all the plugins
  def load_plugins
    @plugin_filenames = Dir[File.join(PSDKPLUG_SCRIPTS_FOLDER, "*.#{PLUGIN_FILE_EXT}")]
    # @type [Array<Config>]
    @old_plugins = load_existing_plugins
    return unless need_to_refresh_plugins?
    show_splash
    cleanup_plugin_scripts
    cleanup_removed_plugins
    @plugins = load_all_plugin_data
    @plugins.each(&:evaluate_pre_compatibility)
    check_dependencies
    @plugins.each_with_index { |plugin, index| plugin.extract(index) }
    ScriptLoader.load_vscode_scripts(File.expand_path(PLUGIN_SCRIPTS_FOLDER))
    @plugins.each(&:evaluate_post_compatibility)
    save_data(@plugins.map(&:config), PLUGIN_INFO_FILE)
  end

    # Function that checks (and download) dependencies of all plugins
  def check_dependencies
    to_download = @plugins.flat_map { |plugin| plugin.dependencies_to_download(@plugins) }
    to_download.uniq(&:name).each(&:download)
    unless to_download.empty?
      @plugin_filenames = Dir[File.join(PSDKPLUG_SCRIPTS_FOLDER, "*.#{PLUGIN_FILE_EXT}")]
      @plugins = load_all_plugin_data
    end
    incompatible_plugins = all_incompatible_plugin_message
    if incompatible_plugins.any?
      pcc 'There\'s plugin incompatibilities!', 0x01
      pcc incompatible_plugins, 0x01
      raise 'Incompatible plugin detected'
    end
    order_dependencies
  end
  class << self
    def filename(plugin)
      File.join(PSDKPLUG_SCRIPTS_FOLDER, "#{plugin.name}.#{PLUGIN_FILE_EXT}")
    end
  end
end