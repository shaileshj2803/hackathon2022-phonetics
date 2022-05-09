<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VoiceRecoder.aspx.cs" Inherits="VoiceRecorder.VoiceRecoder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            color: #FF0000;
        }

/*        body {
            position: absolute;
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-pack: center;
            -webkit-justify-content: center;
                -ms-flex-pack: center;
                    justify-content: center;
            -webkit-box-align: center;
            -webkit-align-items: center;
                -ms-flex-align: center;
                    align-items: center;
            height: 100%;
            width: 100%;
            margin: 0;
        }*/
/*        .holder {
            background-color: #4c474c;
            background-image: -webkit-gradient(linear, left bottom, left top, from(#4c474c), to(#141414));
            background-image: -o-linear-gradient(bottom, #4c474c 0%, #141414 100%);
            background-image: linear-gradient(0deg, #4c474c 0%, #141414 100%);
            border-radius: 50px;
        }*/
        [data-role="controls"] > button {
            margin: 50px auto;
            outline: none;
            display: block;
            border: none;
            background-color: #D9AFD9;
            background-image: -webkit-gradient(linear, left bottom, left top, from(#D9AFD9), to(#97D9E1));
            background-image: -o-linear-gradient(bottom, #D9AFD9 0%, #97D9E1 100%);
            background-image: linear-gradient(0deg, #D9AFD9 0%, #97D9E1 100%);
            width: 100px;
            height: 100px;
            border-radius: 50%;
            text-indent: -1000em;
            cursor: pointer;
            -webkit-box-shadow: 0px 5px 5px 2px rgba(0,0,0,0.3) inset, 
                0px 0px 0px 30px #fff, 0px 0px 0px 35px #333;
                    box-shadow: 0px 5px 5px 2px rgba(0,0,0,0.3) inset, 
                0px 0px 0px 30px #fff, 0px 0px 0px 35px #333;
        }
        [data-role="controls"] > button:hover {
            background-color: #ee7bee;
            background-image: -webkit-gradient(linear, left bottom, left top, from(#ee7bee), to(#6fe1f5));
            background-image: -o-linear-gradient(bottom, #ee7bee 0%, #6fe1f5 100%);
            background-image: linear-gradient(0deg, #ee7bee 0%, #6fe1f5 100%);
        }
        [data-role="controls"] > button[data-recording="true"] {
            background-color: #ff2038;
            background-image: -webkit-gradient(linear, left bottom, left top, from(#ff2038), to(#b30003));
            background-image: -o-linear-gradient(bottom, #ff2038 0%, #b30003 100%);
            background-image: linear-gradient(0deg, #ff2038 0%, #b30003 100%);
        }
        [data-role="recordings"] > .row {
            width: auto;
            height: auto;
            padding: 20px;
        }
        [data-role="recordings"] > .row > audio {
            outline: none;
        }
        [data-role="recordings"] > .row > a {
            display: inline-block;
            text-align: center;
            font-size: 20px;
            line-height: 50px;
            vertical-align: middle;
            width: 50px;
            height: 50px;
            border-radius: 20px;
            color: #fff;
            font-weight: bold;
            text-decoration: underline;
            background-color: #0093E9;
            background-image: -webkit-gradient(linear, left bottom, left top, from(#0093E9), to(#80D0C7));
            background-image: -o-linear-gradient(bottom, #0093E9 0%, #80D0C7 100%);
            background-image: linear-gradient(0deg, #0093E9 0%, #80D0C7 100%);
            float: right;
            margin-left: 20px;
            cursor: pointer;
        }
        [data-role="recordings"] > .row > a:hover {
            text-decoration: none;
        }
        [data-role="recordings"] > .row > a:active {
            background-image: -webkit-gradient(linear, left top, left bottom, from(#0093E9), to(#80D0C7));
            background-image: -o-linear-gradient(top, #0093E9 0%, #80D0C7 100%);
            background-image: linear-gradient(180deg, #0093E9 0%, #80D0C7 100%);
        }
    </style>
    <script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
    <script src="Scripts/recorder.js"></script>
    <script>
        /**
         * Copyright Mark Jivko (https://github.com/markjivko)
         * Licensed under GPL-3.0
         *
         * Modified by Michael Cheng
         */
        jQuery(document).ready(function () {
            var $ = jQuery;
            var myRecorder = {
                objects: {
                    context: null,
                    stream: null,
                    recorder: null
                },
                init: function () {
                    if (null === myRecorder.objects.context) {
                        myRecorder.objects.context = new (
                            window.AudioContext || window.webkitAudioContext
                        );
                    }
                },
                start: function () {
                    var options = { audio: true, video: false };
                    navigator.mediaDevices.getUserMedia(options).then(function (stream) {
                        myRecorder.objects.stream = stream;
                        myRecorder.objects.recorder = new Recorder(
                            myRecorder.objects.context.createMediaStreamSource(stream),
                            { numChannels: 1 }
                        );
                        myRecorder.objects.recorder.record();
                    }).catch(function (err) { });
                },
                stop: function (listObject) {
                    if (null !== myRecorder.objects.stream) {
                        myRecorder.objects.stream.getAudioTracks()[0].stop();
                    }
                    if (null !== myRecorder.objects.recorder) {
                        myRecorder.objects.recorder.stop();

                        // Validate object
                        if (null !== listObject
                            && 'object' === typeof listObject
                            && listObject.length > 0) {
                            // Export the WAV file
                            myRecorder.objects.recorder.exportWAV(function (blob) {
                                var url = (window.URL || window.webkitURL)
                                    .createObjectURL(blob);

                                // Prepare the playback
                                var audioObject = $('<audio controls></audio>')
                                    .attr('src', url);

                                // Prepare the download link
                                //var downloadObject = $('<a>&#9660;</a>')
                                //    .attr('href', url)
                                //    .attr('download', new Date().toUTCString() + '.wav');

                                // Wrap everything in a row
                                var holderObject = $('<div class="row"></div>')
                                    .append(audioObject);
                                //    .append(downloadObject);

                                // Replace in the list. Append if you want to keep previous recordings.
                                listObject.html(holderObject);

                                //Upload base64 encoded blob to server
                                var reader = new FileReader();
                                reader.readAsDataURL(blob);
                                reader.onloadend = function () {
                                    var base64data = reader.result;
                                    //console.log(base64data);
                                    //var DTO = { 'userdata': 'Saran' };
                                    var name = $("#firstname").val() + "_" + $("#lastname").val() + "-Recording.wav";
                                    var DTO = {
                                        'name': name,
                                        'encodedBlob': base64data
                                    };
                                    $.ajax({
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "VoiceRecoder.aspx/Upload",
                                        data: JSON.stringify(DTO),
                                        datatype: "json",
                                        success: function (result) {
                                            //do something
                                            console.log("Successfully posted " + name);
                                            console.log(result);
                                        },
                                        error: function (xmlhttprequest, textstatus, errorthrown) {
                                            alert(" conection to the server failed ");
                                            console.log("error: " + errorthrown);
                                        }
                                    });//end of $.ajax()
                                };
                            });
                        }
                    }
                }
            };

            // Prepare the recordings list
            var listObject = $('[data-role="recordings"]');

            // Prepare the record button
            $('[data-role="controls"] > button').click(function () {
                // Initialize the recorder
                myRecorder.init();

                // Get the button state 
                var buttonState = !!$(this).attr('data-recording');

                // Toggle
                if (!buttonState) {
                    $(this).attr('data-recording', 'true');
                    myRecorder.start();
                } else {
                    $(this).attr('data-recording', '');
                    myRecorder.stop(listObject);
                }
            });
        });
    </script>
</head>
<body>
    <div class="holder">
        <label for="firstname">First Name </label><textarea id="firstname" rows="1" cols="25"></textarea>
        <label for="lastname">Last  Name </label><textarea id="lastname" rows="1" cols="25"></textarea>
        <div data-role="controls">
            <button>Record</button>
        </div>
        <div data-role="recordings"></div>
    </div>


    <form id="form1" runat="server">
        <div>
            &nbsp;<strong>Employee Name: </strong> &nbsp;<asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:ImageButton ID="ImageButton1" runat="server" Height="46" ImageUrl="~/Img/Speak-mic.png" OnClick="ImageButton1_Click" ToolTip="Speak" Width="39px" />
            &nbsp;<asp:Button ID="Btnsavestop" runat="server" Text="Stop and Save" OnClick="Btnsavestop_Click" Height="49px" />
            &nbsp;&nbsp;
            <asp:ImageButton ID="ImageButton2" runat="server" Height="48px" ImageUrl="~/Img/Speaker.png" OnClick="ImageButton2_Click" Width="50px" />
            <br />
            &nbsp;
            <strong>Status&nbsp; :&nbsp;&nbsp; </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblMessage" runat="server" BackColor="#66FF99" Font-Bold="true" ForeColor="Red" Text="Message..."></asp:Label>
            <br />
            <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp;
            <strong>List of All Pronunciation Recorded:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="Button1" runat="server" Height="42px" OnClick="Button1_Click" Text="Get All Recordings" />
            <br />
            <strong>Total Recording (Count)</strong> :
            <asp:Label ID="lbCount" runat="server" BackColor="#FFFF66" Font-Bold="true" ForeColor="Red"></asp:Label>
            <span class="auto-style1"><strong>Did Not Find Recording? Please Try</strong></span><a href="https://mdn.github.io/web-speech-api/speak-easy-synthesis/"><span class="auto-style1"><strong> Here</strong></span></a><span class="auto-style1"><strong>. </strong></span>
        </div>
        <asp:ListBox ID="lstBoxEmployeeRecorded" runat="server" Height="334px" OnSelectedIndexChanged="lstBoxEmployeeRecorded_SelectedIndexChanged" AutoPostBack="true" ToolTip="List of Employee Recorded" Width="294px"></asp:ListBox>
        <br />
    </form>
</body>
</html>
