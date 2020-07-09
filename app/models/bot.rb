class Bot < ApplicationRecord
  attr_accessor :template

  belongs_to :user, optional: true
  belongs_to :parent, class_name: "Bot", optional: true
  has_many :children, class_name: "Bot", foreign_key: "parent_id", dependent: :nullify

  scope :templates, -> { where(user_id: nil) }

  before_save :create_template, if: Proc.new {|bot| bot.user.admin? && !bot.template.to_i.zero? }

  validates :message, presence: {message: '입력 메시지를 입력하세요.'}, uniqueness: { scope: :user_id, message: '존재하는 입력 메세지입니다. 다른 메시지를 입력해 주세요.'}

  def create_template
    self.user_id = nil
  end

  def template?
    self.user_id.nil?
  end

  def fork(user) # Clone bot
    Bot.create(user_id: user.id, parent_id: self.id, message: self.message, prepend: self.prepend, response: self.response)
  end

  def run_code
    Bot.run_code(self.prepend, self.response)
  end

  # require 'timeout'
  def self.run_code(prepend, code)
    code = "#{prepend}\r\n\r\n#{code}"

    # Docker
    # tmp_path = Rails.root.join('tmp','codes',"#{user_id}")
    # Dir.mkdir(tmp_path) unless File.exist?(tmp_path)
    # file = Tempfile.new(['',".#{ENV.fetch("CHATBOT_LANGUAGE_EXTENSION") { 'py' }}"], tmp_path)
    # container_name = File.basename(file,".#{ENV.fetch('CHATBOT_LANGUAGE_EXTENSION') { 'py' }}")
    # begin
    #   file.write(code)
    #   file.rewind
    #   result = Timeout.timeout(5) do
    #     `sudo docker run -t --name=#{container_name} --rm -v #{tmp_path}:/usr/src/app:ro -w /usr/src/app #{ENV.fetch("CHATBOT_LANGUAGE_EN") { 'python' }}-custom timeout --signal=SIGINT 6s #{ENV.fetch("CHATBOT_DOCKER_RUN_COMMAND") { 'python' }} #{File.basename(file)} 2>&1`
    #   end
    # rescue Timeout::Error
    #   system("sudo docker stop #{container_name}")
    #   result = '[최대 실행 시간 5초를 초과하였습니다. 실행을 중단합니다.]'
    # ensure
    #   file.close
    #   file.unlink
    # end

    # AWS Lambda Initial
    lambda_client = Aws::Lambda::Client.new(
      region: 'ap-northeast-2',
      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
    )

    # Invoke Lambda Function
    request_payload = {code: code}
    payload = JSON.generate(request_payload)
    response = lambda_client.invoke({
                 function_name: "run_code_#{ENV.fetch("CHATBOT_LANGUAGE_EN") { 'python' }}",
                 invocation_type: 'RequestResponse',
                 log_type: 'None',
                 payload: payload
               })
    response_payload = JSON.parse(response.payload.string) # , symbolize_names: true)

    if response_payload['statusCode'] == 200
      result = response_payload['body']
    else
      result = "[#{response_payload['errorType']||'-'}] #{response_payload['errorMessage']}"
    end

    return result #.force_encoding('ISO-8859-1').encode('UTF-8') # Encoding Issue
  end
end
