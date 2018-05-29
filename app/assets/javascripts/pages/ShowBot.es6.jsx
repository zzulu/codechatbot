class ShowBot extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      template: this.props.bot.userId ? false : true,
      forked: this.props.bot.parendId ? true : false,
      result: ''
    }
  }

  runCode(response) {
    this.setState({ result: response });
  }

  renderTag(userId) {
    if(!userId) {
      return(
        <span className="tag--tamplate ml-2">템플릿</span>
      );
    }
  }

  renderButton(id, template, forked, role) {
    if (forked) {
      return(
        <React.Fragment>
          <a href={`/bots/${id}/edit`} className="btn btn-info">수정</a>
          <a href={`/bots/${id}`} data-method="delete" data-confirm="초기화하시겠습니까?" className="btn btn-danger">초기화</a>
        </React.Fragment>
      );
    } else if (!template || (role === 'admin')) {
      return(
        <React.Fragment>
          <a href={`/bots/${id}/edit`} className="btn btn-info">수정</a>
          <a href={`/bots/${id}`} data-method="delete" data-confirm="삭제하시겠습니까?" className="btn btn-danger">삭제</a>
        </React.Fragment>
      );
    } else {
      return(
        <a href={`/bots/${id}/edit`} className="btn btn-info">수정</a>
      );
    }
  }

  render() {
    return(
      <div className="container">
        <div className="row bot">
          <div className="col-12 col-lg-6">
            <label className="bot--label">입력 메시지{this.renderTag(this.props.bot.userId)}</label>
            <p className="bot--message">{this.props.bot.message}</p>

            <label className="bot--label">답변 코드</label>
            <CodeMirrorReadOnly value={this.props.bot.response} />
            
            <div className="d-flex justify-content-between py-3">
              <div className="bot--button">
                {this.renderButton(this.props.bot.id, this.state.template, this.state.forked, this.props.role)}
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
