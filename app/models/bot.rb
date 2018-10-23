class Bot < ApplicationRecord
  attr_accessor :template

  belongs_to :user, optional: true
  belongs_to :parent, class_name: "Bot", optional: true
  has_many :children, class_name: "Bot", foreign_key: "parent_id", dependent: :nullify

  scope :templates, -> { where(user_id: nil) }

  before_create :make_template, if: Proc.new {|bot| bot.template && bot.user.admin? }

  validates :message, presence: {message: '입력 메시지를 입력하세요.'}, uniqueness: { scope: :user_id, message: '존재하는 입력 메세지입니다. 다른 메시지를 입력해 주세요.'}

  def make_template
    self.user_id = nil
  end

  def template?
    self.user_id.nil?
  end

  def fork(user) # Clone bot
    Bot.create(user_id: user.id, parent_id: self.id, message: self.message, prepend: self.prepend, response: self.response)
  end

  def run_code
    Bot.run_code(self.user_id || 0, self.prepend, self.response)
  end

  require 'timeout'
  def self.run_code(user_id, prepend, code)
    code = "#{prepend}\r\n\r\n#{code}"
    tmp_path = Rails.root.join('tmp','codes',"#{user_id}")
    Dir.mkdir(tmp_path) unless File.exist?(tmp_path)
    file = Tempfile.new(['',".#{ENV.fetch("CHATBOT_LANGUAGE_EXTENSION") { 'rb' }}"], tmp_path)
    container_name = File.basename(file,".#{ENV.fetch('CHATBOT_LANGUAGE_EXTENSION') { 'rb' }}")
    begin
      file.write(code)
      file.rewind
      result = Timeout.timeout(3) do
        `sudo docker run -t --name=#{container_name} --rm -v #{tmp_path}:/usr/src/app:ro -w /usr/src/app #{ENV.fetch("CHATBOT_LANGUAGE_EN") { 'ruby' }}-custom #{ENV.fetch("CHATBOT_DOCKER_RUN_COMMAND") { 'ruby' }} #{File.basename(file)} 2>&1`
      end
    rescue Timeout::Error
      system("sudo docker stop #{container_name}")
      result = '[최대 실행 시간 3초를 초과하였습니다. 실행을 중단합니다.]'
    ensure
      file.close
      file.unlink
    end
    return result #.force_encoding('ISO-8859-1').encode('UTF-8') # Encoding Issue
  end
end
