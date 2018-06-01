class BotForm extends React.Component {
  constructor(props) {
    super(props);
    this.initCodeMirror = this.initCodeMirror.bind(this);
    this.state = {
      botId: this.props.bot.id ? `/${this.props.bot.id}`:'',
      message: this.props.bot.message ? this.props.bot.message:'',
      response: this.props.bot.response ? this.props.bot.response:'',
      template: this.props.bot.userId ? false : true,
      errorsClass: {
        message: this.props.errors.message ? 'is-invalid':''
      }
    }
  }

  // CodeMirror configure
  betterTab(cm) {
    if (cm.somethingSelected()) {
      cm.indentSelection("add");
    } else {
      cm.replaceSelection(cm.getOption("indentWithTabs")? "\t":
        Array(cm.getOption("indentUnit") + 1).join(" "), "end", "+input");
    }
  }

  initCodeMirror() {
    editor = CodeMirror.fromTextArea(this.refs.codeEditor, {
      lineNumbers: true,
      mode: 'ruby',
      theme: 'monokai',
      extraKeys: { Tab: this.betterTab }
    });

    editor.on("change", (cm) => {
      this.setState({response: cm.getValue()});
    })
  }

  componentDidMount() {
    this.initCodeMirror();
  }

  renderTemplateCheckbox(template, role) {
    if(role === 'admin') {
      return(
        <div className="custom-control custom-checkbox mb-3">
          <input type="checkbox" id="bot_template" className="custom-control-input" name="bot[template]" defaultChecked={template} onChange={(e)=>this.setState({template: e.target.checked})} />
          <label className="custom-control-label" htmlFor="bot_template">이 챗봇은 템플릿 입니다.</label>
        </div>
      );
    }
  }

  renderErrorMessage(message) {
    return(
      <small className="form-text invalid-feedback">{message}</small>
    );
  }

  renderMethod(method) {
    if (method !== 'post') {
      return (
        <input type="hidden" name="_method" value={method} />
      );
    }
  }

  render () {
    return (
      <form action={`/bots${this.state.botId}`} method="post" encType="multipart/form-data" acceptCharset="UTF-8">
        <input name="utf8" type="hidden" value="✓" />
        {this.renderMethod(this.props.method)}
        <input type="hidden" name="authenticity_token" value={this.props.formAuthenticityToken} />
        <div className="form-group">
          <label htmlFor="bot_message" className="required">입력 메시지</label>
          <input type="text" id="bot_message" name="bot[message]" value={this.state.message} onChange={(e)=>this.setState({message: e.target.value})} className={`form-control ${this.state.errorsClass.message}`} autoComplete="off" />
          {this.renderErrorMessage(this.props.errors.message)}
        </div>
        <div className="form-group">
          <label htmlFor="bot_response" className="required">답변 코드</label>
          <textarea ref="codeEditor" className="form-control" name="bot[response]" value={this.state.response} readOnly={true} rows="10"></textarea>
        </div>

        {this.renderTemplateCheckbox(this.state.template, this.props.role)}

        <div className="d-flex justify-content-between pb-3">
          <button type="submit" className="btn btn-primary">저장</button>
          <button type="button" className="btn btn-success" onClick={()=>this.props.runCode(this.state.response)} disabled={this.props.loading}>실행</button>
        </div>
      </form>
    );
  }
}

BotForm.propTypes = {
  formAuthenticityToken: PropTypes.string,
  method: PropTypes.string,
  role: PropTypes.string,
  bot: PropTypes.object,
  errors: PropTypes.object,
  loading: PropTypes.bool
};

BotForm.defaultProps = {
  method: 'post'
}
