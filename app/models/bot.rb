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

  def self.run_code(code)
    code = "require 'timeout'\r\nTimeout::timeout(2) do\r\n#{code}\r\nend"
    tmp_path = '/home/ubuntu/rubychatbot/tmp/'
    file = Tempfile.new(['','.rb'], tmp_path)
    begin
      file.write(code)
    ensure
      file.close
      result = `sudo docker run -t --rm -v #{tmp_path}:/usr/src/app:ro -w /usr/src/app ruby-custom-gem ruby #{file.path.gsub(tmp_path,'')} 2>&1`
      file.unlink
    end
    return result
  end

  def run_code
    Bot.run_code(self.response)
  end

  def fork(user)
    # Clone bot
    Bot.create(user_id: user.id, parent_id: self.id, message: self.message, response: self.response)
  end
 end
