class NewBot extends React.Component {
  constructor(props) {
    super(props);
    this.runCode = this.runCode.bind(this);
    this.state = {
      result: ''
    }
  }

  runCode(response) {
    this.setState({ result: response });
  }

  render() {
    return(
      <div className="container">
        <div className="row bot">
          <div className="col-12 col-lg-6">
            <BotForm
              formAuthenticityToken={this.props.formAuthenticityToken}
              method="post"
              runCode={this.runCode} />
          </div>
          <div className="col-12 col-lg-6">
            <BotResult result={this.state.result}/>
          </div>
        </div>
      </div>
    );
  }
}

NewBot.propTypes = {
  formAuthenticityToken: PropTypes.string
};
