class Bots extends React.Component {
  render() {
    return(
      <React.Fragment>
        <div className="row bots--head">
          <div className="col-12 col-sm-3">
            입력 메시지
          </div>
          <div className="col-12 col-sm-9">
            답변 코드
          </div>
        </div>
        { this.props.bots.map((bot)=>(
          <Bot key={bot.id} bot={bot} editing={this.props.editing} deleteBot={this.props.deleteBot} languageEn={this.props.languageEn} />
        ))}
      </React.Fragment>
    );
  }
}

Bots.propTypes = {
  bots: PropTypes.array,
  editing: PropTypes.bool,
  languageEn: PropTypes.string
}
