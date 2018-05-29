class BotResult extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      result: this.props.result || ''
    }
  }

  componentWillReceiveProps(nextProps) {
    this.setState({result: nextProps.result});
  }

  render(){
    return(
      <React.Fragment>
        <label>실행 결과</label>
        <pre className="bot--result">{this.state.result}</pre>
      </React.Fragment>
    );
  }
}

BotResult.propTypes = {
  result: PropTypes.string
}
