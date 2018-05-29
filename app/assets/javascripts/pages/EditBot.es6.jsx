class EditBot extends React.Component {
  constructor(props) {
    super(props);
    this.runCode = this.runCode.bind(this);
    this.state = {
      result: ''
    }
  }

  runCode(response) {
    $.ajax({
      url: `/bots/run_code`, type: 'POST', dataType: 'json',
      data: { code: response }
    }).done((response)=>{
      this.setState({ result: response.result });
    });
  }

  render() {
    return(
      <div className="container">
        <div className="row bot">
          <div className="col-12 col-lg-6">
            <BotForm
              formAuthenticityToken={this.props.formAuthenticityToken}
              method="put"
              role={this.props.role}
              bot={this.props.bot}
              runCode={this.runCode}
              errors={this.props.errors} />
          </div>
          <div className="col-12 col-lg-6">
            <BotResult result={this.state.result}/>
          </div>
        </div>
      </div>
    );
  }
}

EditBot.propTypes = {
  formAuthenticityToken: PropTypes.string,
  bot: PropTypes.object,
  errors: PropTypes.object
};
