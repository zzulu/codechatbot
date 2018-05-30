class BotResult extends React.Component {
  renderResult(loading) {
    if(loading) {
      return(
        <ResultSpinner/>
      );
    } else {
      return(
        <pre>{this.props.result}</pre>
      );
    }
  }

  render(){
    return(
      <React.Fragment>
        <label>실행 결과</label>
        <div className="bot--result">
          {this.renderResult(this.props.loading)}
        </div>
      </React.Fragment>
    );
  }
}

BotResult.propTypes = {
  loading: PropTypes.bool,
  result: PropTypes.string
}
