class ShowBot extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      result: ''
    }
  }

  runCode(response) {
    this.setState({ result: response })
  }

  render() {
    return(
      <div className="container">
        <div className="row py-5">
          <div className="col-6">
            <label>입력 메시지</label>
            <p>{this.props.bot.message}</p>

            <label>답변 코드</label>
            <CodeMirrorReadOnly value={this.props.bot.response} />
            
            <div className="py-3">
              <a href={`/bots/${this.props.bot.id}/edit`} className="btn btn-outline-info">수정</a>
              <a href={`/bots/${this.props.bot.id}`} data-method="delete" className="btn btn-outline-danger">삭제</a>
              <button className="btn btn-outline-success" onClick={()=>this.runCode(this.props.bot.response)}>실행</button>
            </div>
          </div>
          <div className="col-6">
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
