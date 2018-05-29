class Bot extends React.Component {
  renderButton(editing, userId, parentId, id) {
    if(editing && userId && !parentId) {
      return(
        <span className="item--button" onClick={()=>this.props.deleteBot(this.props.bot.id)}><i className="fas fa-times"></i></span>
      );
    }
  }

  renderTag(userId) {
    if(!userId) {
      return(
        <span className="tag--tamplate mr-2">템플릿</span>
      );
    }
  }

  render () {
    return (
      <div className="row bots--item">
        <div className="col-12 col-sm-3 mb-2 mb-sm-0">
          {this.renderTag(this.props.bot.userId)}
          <a href={`/bots/${this.props.bot.id}`}>{this.props.bot.message}</a>
          {this.renderButton(this.props.editing, this.props.bot.userId, this.props.bot.parentId, this.props.bot.id)}
        </div>
        <div className="col-12 col-sm-9">
          <CodeMirrorReadOnly value={this.props.bot.response} heightAuto={true} />
        </div>
      </div>
    );
  }
}

Bot.propTypes = {
  bot: PropTypes.object
};
