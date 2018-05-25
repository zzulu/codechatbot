class NewBot extends React.Component {
  render () {
    return (
      <div className="container">
        <div className="row">
          <BotForm
            formAuthenticityToken={this.props.formAuthenticityToken}
            method="post" />
        </div>
      </div>
    );
  }
}

NewBot.propTypes = {
  formAuthenticityToken: PropTypes.string
};
