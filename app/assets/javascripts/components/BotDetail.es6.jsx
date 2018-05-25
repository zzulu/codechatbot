class BotDetail extends React.Component {
  render() {
    return(
      <div className="container">
        <div className="row">
          <div className="col-6 offset-6 text-right py-3">
            <a href={`/bots/${this.props.bot.id}/edit`} className="btn btn-outline-info">수정</a>
            <a href={`/bots/${this.props.bot.id}`} data-method="delete" className="btn btn-outline-danger">삭제</a>
          </div>
        </div>
        <div className="row">
          <div className="col-6">
            <label>입력 메시지</label>
            <p>{this.props.bot.message}</p>

            <label>답변 코드</label>
            <div className="readonly-editor">
              <textarea className="readonly_code" rows="10" value={this.props.bot.response} readOnly={true}></textarea>
            </div>
          </div>
          <div className="col-6">
            <label>실행 결과</label>
            <div></div> 
          </div>
        </div>
      </div>
    );
  }
}

BotDetail.propTypes = {
  bot: PropTypes.object
};
