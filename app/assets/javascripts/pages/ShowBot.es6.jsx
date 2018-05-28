class ShowBot extends React.Component {
  constructor(props) {
    super(props);
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
            <label className="bot--label">입력 메시지</label>
            <p className="bot--message">{this.props.bot.message}</p>

            <label className="bot--label">답변 코드</label>
            <CodeMirrorReadOnly value={this.props.bot.response} />
            
            <div className="d-flex justify-content-between pt-3">
              <div className="bot--button">
                <a href={`/bots/${this.props.bot.id}/edit`} className="btn btn-info">수정</a>
                <a href={`/bots/${this.props.bot.id}`} data-method="delete" data-confirm="삭제하시겠습니까?" className="btn btn-danger">삭제</a>
                <a href="/bots" className="btn btn-secondary">목록</a>
              </div>
              <button className="btn btn-success" onClick={()=>this.runCode(this.props.bot.response)}>실행</button>
            </div>
          </div>
          <div className="col-12 col-lg-6">
            <BotResult result={this.state.result}/>
          </div>
        </div>
      </div>
    );
  }
}

ShowBot.propTypes = {
  bot: PropTypes.object
};
