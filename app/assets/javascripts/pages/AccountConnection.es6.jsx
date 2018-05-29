class AccountConnection extends React.Component {
  constructor(props) {
    super(props);
    this.initPusher = this.initPusher.bind(this);
    this.state = {
      pendingClass: 'btn-outline-success disabled connection--pending',
      pendingContent: '인증 대기'
    }
  }

  initPusher() {
    pusher = new Pusher(this.props.pusherKey, { cluster: 'ap1', encrypted: true });

    channel = pusher.subscribe('account-connection');
    channel.bind('cennection-success', (data) => {
      if (data.code == this.props.connectionCode) {
        this.setState({
          pendingClass: 'btn-success connection--success',
          pendingContent: '인증 완료'
        })
      }
    });
  }

  componentDidMount() {
    this.initPusher();
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
          <div className="connection--button">
            <a href="/bots" className={`btn ${this.state.pendingClass}`}>
              {this.state.pendingContent}
              <div className="border--spinner"></div>
            </a>
          </div>
        </div>
      </div>
    );
  }
}

AccountConnection.propTypes = {
  connectionCode: PropTypes.string,
  pusherKey: PropTypes.string
}
