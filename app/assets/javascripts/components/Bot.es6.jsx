class Bot extends React.Component {
  renderButton(editing, id) {
    if(editing) {
      return(
        <span className="item--button" onClick={()=>this.props.deleteBot(this.props.bot.id)}><i className="fas fa-times"></i></span>
      );
    }
  }

  render () {
    return (
      <div className="row bots--item">
        <div className="col-12 col-sm-3 mb-2 mb-sm-0">
          <a href={`/bots/${this.props.bot.id}`}>{this.props.bot.message}</a>
          {this.renderButton(this.props.editing, this.props.bot.id)}
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
