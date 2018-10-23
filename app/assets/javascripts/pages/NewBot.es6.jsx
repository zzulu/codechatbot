class NewBot extends React.Component {
  constructor(props) {
    super(props);
    this.runCode = this.runCode.bind(this);
    this.state = {
      result: '',
      loading: false
    }
  }

  runCode(prepend, response) {
    this.setState({ loading: true });
    $.ajax({
      url: `/bots/run_code`, type: 'POST', dataType: 'json',
      data: { prepend: prepend, code: response }
    }).done((response)=>{
      this.setState({ result: response.result, loading: false });
    }).fail((error)=>{
      this.setState({ result: `${error.statusText} (${error.status})`, loading: false})
    });
  }

  render() {
    return(
      <div className="container">
        <div className="row bot">
          <div className="col-12 col-lg-6">
            <BotForm
              formAuthenticityToken={this.props.formAuthenticityToken}
              method="post"
              role={this.props.role}
              bot={this.props.bot}
              runCode={this.runCode}
              errors={this.props.errors}
              loading={this.state.loading}
              mode={this.props.languageEn} />
          </div>
          <div className="col-12 col-lg-6">
            <BotResult result={this.state.result} loading={this.state.loading} />
          </div>
        </div>
      </div>
    );
  }
}

NewBot.propTypes = {
  formAuthenticityToken: PropTypes.string,
  bot: PropTypes.object,
  errors: PropTypes.object,
  languageEn: PropTypes.string,
};
