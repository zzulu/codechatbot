class IndexBots extends React.Component {
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
    this.deleteBot = this.deleteBot.bind(this);
    this.state = {
      bots: this.props.bots,
      editing: false
    }
  }

  handleClick(editing) {
    this.setState({editing: !editing});
  }

  editClassName(editing) {
    return editing? 'btn-info':'btn-outline-info'
  }

  editContent(editing) {
    return editing? '완료':'편집'
  }

  deleteBot(id) {
    const bots = this.state.bots.filter((bot) => bot.id !== id)
    $.ajax({ url: `/bots/${id}`, type: 'DELETE', dataType: 'json' });
    this.setState({bots: bots});
  }

  render () {
    return (
      <div className="container bots">
        <div className="bots--button d-flex justify-content-end">
          <a href="/bots/new" className="btn btn-primary">봇 만들기</a>
          <button className={`btn ${this.editClassName(this.state.editing)}`} onClick={()=>this.handleClick(this.state.editing)}>{this.editContent(this.state.editing)}</button>
        </div>
        <Bots bots={this.state.bots} editing={this.state.editing} deleteBot={this.deleteBot} languageEn={this.props.languageEn} />
    </div>
    );
  }
}

IndexBots.propTypes = {
  bots: PropTypes.array,
  languageEn: PropTypes.string
};

