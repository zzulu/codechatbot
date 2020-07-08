class AccountConnection extends React.Component {
  constructor(props) {
    super(props);
    this.initPusher = this.initPusher.bind(this);
    this.state = {
      pendingClass: 'btn-outline-success disabled connection--pending',
      pendingContent: '인증 대기',
      redirectPath: this.props.redirectPath
    }
  }

  initPusher() {
    this.pusher = new Pusher(this.props.pusherKey, { cluster: 'ap1', encrypted: true });

    channel = this.pusher.subscribe(`account-connection-${this.props.connectionCode}`);

    channel.bind('connected', (data) => {
      if(this.props.connectionCode == data.code) {
        this.setState({
          pendingClass: 'btn-success connection--success',
          pendingContent: '인증 완료'
        });
        this.pusher.unsubscribe(`account-connection-${this.props.connectionCode}`);
      }
    });

    channel.bind('authenticated', (data) => {
      if (data.token) {
        this.setState({
          pendingClass: 'btn-success connection--success',
          pendingContent: '인증 완료',
          redirectPath: `${this.state.redirectPath}?reset_password_token=${data.token}`
        });
        this.pusher.unsubscribe(`account-connection-${this.props.connectionCode}`);
      }
    });
  }

  componentDidMount() {
    this.initPusher();
  }

  componentWillUnmount() {
    this.pusher.disconnect();
  }

  render() {
    return(
      <div className="container">
        <div className="connection">
          <h3>{this.props.header}</h3>
          <p className="connection--text">
            {this.props.text}
          </p>
          <div className="connection--code-wrapper">
            {this.props.connectionCode.split('').map((c, i)=>(
              <span key={i} className="connection--code-char">{c}</span>
            ))}
          </div>
          <div className="connection--button">
            <a href={this.state.redirectPath} className={`btn ${this.state.pendingClass}`}>
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
