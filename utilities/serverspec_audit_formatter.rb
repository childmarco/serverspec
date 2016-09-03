require 'rspec/core/formatters/documentation_formatter'
require 'specinfra'
require 'serverspec/version'
require 'serverspec/type/base'
require 'serverspec/type/command'
require 'fileutils'
require 'specinfra/backend/ssh'
require 'specinfra/backend/extension/ssh_su'

class ServerspecAuditFormatter < RSpec::Core::Formatters::DocumentationFormatter
  RSpec::Core::Formatters.register self, :example_group_started,
                                   :example_passed, :example_pending, :example_failed

  def initialize(output)
    super
    @seq = 0
  end

  def example_group_started(notification)
    @seq = 0 if @group_level == 0
    super
  end

  def example_passed(notification)
    save_evidence(notification.example)
    super
  end

  def example_pending(notification)
    save_evidence(notification.example)
    super
  end

  def example_failed(notification)
    save_evidence(notification.example, notification.exception)
    super
  end

  def save_evidence(example, exception=nil)

    # 出力先ディレクトリを {ホスト名}/{テスト名}/{連番} で作成
    now_time = Time.now
    @dir     = "./test_result/#{ENV['EXEC_TIME']}"
    FileUtils.mkdir_p(@dir)

    # 実行内容をファイル出力
    Dir.chdir("./test_result/#{ENV['EXEC_TIME']}") do
      # 実行コマンド
      File.open('evidence.txt', 'a') do |f|
        f.puts "============== " + example.example_group.top_level_description + "=========================="
        if example.metadata[:command].nil? == false
          f.puts "###command\n" + example.metadata[:command].gsub('\\', '')[145..-1] + "\n" # <-- gsubはエスケープ文字の"\"を消して見やすくするため。[145..-1]は環境変数の設定など、共通部分を極力表示させたくないので。"145"という文字数は環境に合わせて修正してください。
        end
        if example.metadata[:stdout].nil? == false
          f.puts "\n###stdout\n"
          f.puts(example.metadata[:stdout])
        end
        if example.metadata[:stderr].nil? == false
          f.puts "\n###stderr\n"
          f.puts(example.metadata[:stderr])
        end
        if exception.nil? == false
          f.puts "\n###exception\n"
          f.puts(exception.message)
        end
        resource = example.metadata[:described_class]
        if resource.kind_of? Serverspec::Type::Command
          f.puts "\n###res_stderr\n"
          f.puts(resource.stderr) unless resource.stderr.to_s.empty?
          f.puts "\n###exit_status\n"
          f.puts('exit_status:' + resource.exit_status.to_s)
        end
      end
    end
  end
end