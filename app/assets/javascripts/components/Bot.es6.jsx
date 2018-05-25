class Bot extends React.Component {
  render () {
    return (
      <div className="row">
        <div className="col-3">
          {this.props.bot.message}       
        </div>
        <div className="col-6">
          <CodeMirrorReadOnly value={this.props.bot.response} heightAuto={true} />
        </div>
        <div className="col-3">
          <a href={`/bots/${this.props.bot.id}`}>보기</a>
          <a href={`/bots/${this.props.bot.id}/edit`}>수정</a>
          <a href={`/bots/${this.props.bot.id}`} data-method='delete'>삭제</a>
        </div>
      </div>
    );
  }
}

Bot.propTypes = {
  bot: PropTypes.object
};
