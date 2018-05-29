class CodeMirrorReadOnly extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      heightAutoClass: this.props.heightAuto ? 'height-auto' : ''
    }
  }

  initCodeMirror() {
    CodeMirror.fromTextArea(this.refs.readOnlyEditor, {
      lineNumbers: true,
      mode: 'ruby',
      theme: 'monokai',
      readOnly: true
    });
  }

  componentDidMount() {
    this.initCodeMirror();
  }

  render() {
    return(
      <div className={`readonly-editor ${this.state.heightAutoClass}`}>
        <textarea ref="readOnlyEditor" value={this.props.value} readOnly={true} rows="10"></textarea>
      </div>
    );
  }
}

CodeMirrorReadOnly.propTypes = {
  value: PropTypes.string,
  heightAuto: PropTypes.bool
}

CodeMirrorReadOnly.defaultProps = {
  heightAuto: false
}

