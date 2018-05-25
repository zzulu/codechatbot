class EditBot extends React.Component {
  render () {
    return (
      <div className="container">
        <div className="row">
          <BotForm
            formAuthenticityToken={this.props.formAuthenticityToken}
            method="put"
            bot={this.props.bot} />
        </div>
      </div>
    );
  }
}

EditBot.propTypes = {
  formAuthenticityToken: PropTypes.string,
  bot: PropTypes.object
};
