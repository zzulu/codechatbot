class EditBot extends React.Component {
  constructor(props) {
    super(props);
    this.runCode = this.runCode.bind(this);
    this.state = {
      result: ''
    }
  }

  runCode(response) {
    this.setState({result: response})
  }

  render () {
    return (
      <div className="container">
        <div className="row py-5">
          <div className="col-6">
            <BotForm
            formAuthenticityToken={this.props.formAuthenticityToken}
            method="put"
            bot={this.props.bot}
            runCode={this.runCode}/>
          </div>
          <div className="col-6">
            <BotResult result={this.state.result}/>
          </div>
        </div>
      </div>
    );
  }
}

EditBot.propTypes = {
  formAuthenticityToken: PropTypes.string,
  bot: PropTypes.object
};
