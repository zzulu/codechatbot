class AccountConnection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      pendingClass: 'btn-outline-success disabled',
      pendingContent: '인증 대기 중'
    }
  }

  render() {
    return(
      <div className="container">
        <div className="connection">
          <h3>계정 연결 코드</h3>
          <p className="connection--text">
            카카오톡 계정 연결을 위하여, 루비챗봇 플러스 친구 대화방에서 아래의 코드를 입력하세요.
          </p>
          <div className="connection--code-wrapper">
            {this.props.connectionCode.split('').map((c, i)=>(
              <span key={i} className="connection--code-char">{c}</span>
            ))}
          </div>
          <div className="connection--pending">
            <a href="/" className={`btn ${this.state.pendingClass}`}>{this.state.pendingContent}</a>
          </div>
        </div>
      </div>
    );
  }
}

AccountConnection.propTypes = {
  connectionCode: PropTypes.string
}
